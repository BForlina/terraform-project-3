# terraform-project-3
                      ┌─────────────────┐
                      │     Internet     │
                      └─────────────────┘
                               │
                               ▼
                     ┌─────────────────┐
                     │   Bastion Host   │  (Optional, SSH access to private EC2)
                     └─────────────────┘
                               │
                               ▼
                     ┌─────────────────┐
                     │   Public Subnet  │
                     │   (Web Tier)     │
                     └─────────────────┘
                               │
                               ▼
                     ┌─────────────────┐
                     │ Auto Scaling EC2 │
                     │   NGINX Web     │
                     └─────────────────┘
                               │
        ┌──────────────────────┼──────────────────────┐
        │                      │                      │
        ▼                      ▼                      ▼
┌──────────────┐        ┌──────────────┐        ┌──────────────┐
│ Private Sub1 │        │ Private Sub2 │        │ NAT Gateway  │
│   (RDS AZ1)  │        │   (RDS AZ2)  │        │ Public Sub   │
└──────────────┘        └──────────────┘        └──────────────┘
        │                      │
        ▼                      ▼
┌───────────────────────────┐
│     Multi-AZ RDS MySQL    │
│     Private Database Tier │
└───────────────────────────┘