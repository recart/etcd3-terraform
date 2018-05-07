module "iam_pki" {
  source = "modules/tf_aws_iam/iam_instance_profile"
  name   = "${var.environment}-pki"

  assume_role_policy = <<EOS
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": { "Service": "ec2.amazonaws.com"},
      "Action": "sts:AssumeRole"
   }
  ]
}
EOS

  iam_role_policy = <<EOS
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": [
                "${ module.s3_pki.bucket_arn}"
            ]
       },
        {
            "Action": [
                "s3:Get*"
            ],
            "Effect": "Allow",
            "Resource": [
                "${ module.s3_pki.bucket_arn}/*"
            ]
       }
    ]
}
EOS
}

module "iam_etcd" {
  source = "modules/tf_aws_iam/iam_instance_profile"
  name   = "${var.environment}-etcd"

  assume_role_policy = <<EOS
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": { "Service": "ec2.amazonaws.com"},
      "Action": "sts:AssumeRole"
   }
  ]
}
EOS

  iam_role_policy = <<EOS
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeAddresses",
        "ec2:DescribeInstances",
        "ec2:DescribeVolumes",
        "ec2:DescribeVolumeStatus",
        "ec2:AttachVolume",
        "ec2:DetachVolume"
      ],
      "Resource": "*"
   },
           {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
      "Resource": ["${ module.s3_pki.bucket_arn}","${ module.s3_etcd.bucket_arn}"]
       },
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": ["${ module.s3_pki.bucket_arn}/*","${ module.s3_etcd.bucket_arn}/*"]
   }
  ]
}
EOS
}
