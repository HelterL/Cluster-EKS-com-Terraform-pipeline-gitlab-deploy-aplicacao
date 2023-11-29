resource "aws_iam_role" "eks-cluster" {
  name = "eks-cluster"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "ekscluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluster.name
}

variable "cluster_name" {
  default = "ekscluster"
  type = string
  description = "AWS EKS CLuster Name"
  nullable = false
}

resource "aws_eks_cluster" "ekscluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks-cluster.arn

  vpc_config {
    subnet_ids = [
      var.private_subnet_1a,
      var.private_subnet_1b,
      var.public_subnet_1a,
      var.public_subnet_1b
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.ekscluster-AmazonEKSClusterPolicy]

}