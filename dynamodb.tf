module "dynamodb_table" {
  source = "terraform-aws-modules/dynamodb-table/aws"

  name                = "my-table-${var.name}"
  hash_key            = "Id"
  range_key           = "Species"
  billing_mode        = "PROVISIONED"
  read_capacity       = 2
  write_capacity      = 2
#   autoscaling_enabled = true

#   autoscaling_read = {
#     scale_in_cooldown  = 50
#     scale_out_cooldown = 40
#     target_value       = 45
#     max_capacity       = 10
#   }

#   autoscaling_write = {
#     scale_in_cooldown  = 50
#     scale_out_cooldown = 40
#     target_value       = 45
#     max_capacity       = 10
#   }

#   autoscaling_indexes = {
#     TitleIndex = {
#       read_max_capacity  = 30
#       read_min_capacity  = 10
#       write_max_capacity = 30
#       write_min_capacity = 10
#     }
#   }

  attributes = [
    {
      name = "Id"
      type = "N"
    },
    {
      name = "Species"
      type = "S"
    }
  ]

#   global_secondary_indexes = [
#     {
#       name               = "TitleIndex"
#       hash_key           = "title"
#       range_key          = "age"
#       projection_type    = "INCLUDE"
#       non_key_attributes = ["id"]
#       write_capacity     = 10
#       read_capacity      = 10
#     }
#   ]

  tags = {
    Name = var.name
  }
}