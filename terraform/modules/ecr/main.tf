resource "aws_ecr_repository" "ecr_repo" {
    name = var.ecr_repo
    force_delete = true
}

locals {
  aws_profile = "default" # AWS profile

  ecr_reg   = "${var.aws_account}.dkr.ecr.${var.aws_region}.amazonaws.com"   # ECR docker registry URI
  image_tag = "latest"                                                       # image tag

  dkr_img_src_sha256 = sha256(join("", [for f in fileset(".", "${var.dkr_img_src_path}/**") : file(f)]))

  # Only works if line endings of this file is LF
  dkr_build_cmd = <<-EOT
        docker build -t ${local.ecr_reg}/${var.ecr_repo}:${local.image_tag} -f ${var.dkr_img_src_path}/Dockerfile ${var.dkr_img_src_path}
        awsv2 --profile ${local.aws_profile} ecr get-login-password --region ${var.aws_region} | \
            docker login --username AWS --password-stdin ${local.ecr_reg}
        docker push ${local.ecr_reg}/${var.ecr_repo}:${local.image_tag}
    EOT
}

# local-exec for build and push of docker image
resource "null_resource" "build_push_dkr_img" {
  triggers = {
    detect_docker_source_changes = var.force_image_rebuild == true ? timestamp() : local.dkr_img_src_sha256
  }
  provisioner "local-exec" {
    command = local.dkr_build_cmd
  }
}

output "trigged_by" {
  value = null_resource.build_push_dkr_img.triggers
}
