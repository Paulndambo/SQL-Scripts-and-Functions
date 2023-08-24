# Use Cases
## Group Schemes (Legacy Plans & Non-Legacy Plans)
## Retail Schemes (Nutun Wellness Funeral & MBD Funeral)
## Telesales (Nutun Telesales Funeral)

# 1. Group Schemes Case (Legacy & Non-Legacy Plans)
### On the admin dashboard, follow the normal procedure of creating a scheme group,
### -> Instead of adding members manually, copy the scheme group id, the copied scheme group id will be included 
### -> on the payload body...All this is required since we have not done frontend integration yet



```
Endpoint: https://nutuncover-dev.click2sure.co.za/api/v0/policies/bulk-members-upload/

Sample Payload: 
{
    "scheme_group_id": "this is the id of the newly created scheme group",
    "file": "this is the file containing members to upload"
}

Sample Response
    Success: 
        {
            "message": "New Members Data Submitted",
            "Scheme Group ID": <scheme group id value>
        }

    Failure: 
        {
            "detail": "Bad Request"
        }

TEST RESULTS
Members Count: 50                  Time: 48.6 ms
Members Count: 62                  Time: 58.2 ms

```


# 2. Retail Schemes Case
```
Endpoint: https://nutuncover-dev.click2sure.co.za/api/v0/policies/bulk-members-upload/

In progress
```

# Telesales Case
### Even though Nutun Telesales Funeral is a retail scheme, its configurations are different since, to get the premium
### we need to know the cover level initially,
### The data to be uploaded is expected to either have;- Cover Levels or Premiums
```
Endpoint: https://nutuncover-dev.click2sure.co.za/api/v0/policies/bulk-members-upload/

In progress
```