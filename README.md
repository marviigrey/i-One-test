This is a test environment for i-One application:
We are making use of an AWS environment. Here, i am setting up an Infrastructure using terraform on the AWS cloud platform. 
Resource List:
- VPC
- 4 subnets(2 privates and 2 public )
- Internet Gateway.
- NACL
- route tables
- route table association
- Nat Gateway
- VPC endpoint:
    - interface: AWS KMS service
    - Gsteway: AWS S3
