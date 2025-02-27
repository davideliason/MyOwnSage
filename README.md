## My Own Sage
### Timely Advice in Desperate Times
#### David Eliason

**Description**
The goal of this app is to create a handy source of wisdom that one can easily reach and access, even when not online. Each user can access through curated sources of wisdom and store relevant quotes and text so that, when needed, it is available. The impetus for this project came from an experience of being with somoene in distress, and that was not the best time to be scrambling about looking for the right words to say. Instead, the hope is that those references could be readied prior, in a thoughtful manner, instead of while trying to keep one's wits and sanity!

**Technical**
Using Terraform, created the following in order:
- first, created the VPC
- next, created a public and private subnet within a single Availability Zone (AZ)
- Still within that VPC, created an Internet Gateway and attached it to the VPC. This gives the resources within that VPC access to the internet
- Next, created a route table that is associated with the public subnets. Routes pointing to the IGW was created, so that resources within the public subnet could access the IGW
- created second AZ, with a public subnet within it, and associated the public SN with the public RT too
- created ec2, vpc, security-groups, rds modules for organization and modularity
- created public security group with ports 22 and 80 ingress, open egress
