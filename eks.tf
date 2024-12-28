module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "v20.28.0"
  cluster_name                        = local.name
  cluster_version                     = "1.31"
  vpc_id                              = module.vpc.vpc_id
  subnet_ids                          = module.vpc.private_subnets
  cluster_endpoint_public_access      = true
  cluster_endpoint_private_access     = false
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]
  enable_cluster_creator_admin_permissions = true
  eks_managed_node_groups = {
    default = {
      name          = "awtwins-nodegroup"
      min_size      = 1
      max_size      = 3
      desired_size  = 2
      instance_types = ["t3.medium"]

      tags = {
        "Environment" = "test"
        "Team"        = "awtwins"
      }
    }
  }
}
