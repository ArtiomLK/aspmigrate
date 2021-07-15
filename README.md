# Migrate ASP Apps to Azure

## Introduction

Migrate ASP.Net apps to Azure

## Resources

- App Service Plan
- App Service

## Useful Commands

| Command                                                            | Description        |
| ------------------------------------------------------------------ | ------------------ |
| `Connect-AzAccount`                                                | -                  |
| `Get-AzSubscription`                                               | -                  |
| `Set-AzContext -Subscription xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` | use subscriptionID |
| `Get-AzContext`                                                    | -                  |
| `Get-AzResourceGroup \| Format-Table`                              | -                  |
| `Get-AzLocation \| Format-Table -Property Location, DisplayName`   | -                  |

## PowerShell Scrips

1. ## Initialize Params

   ```PowerShell
    # ---
    # REQUIRED
    # Replace the following param values within $p
    # ---
    $p = @{
      Suffix = "lk" # MUST be 3 or less characters e.g. alk (OK), arlk (NOT OK)
      Location = "EastUS2"
    }; echo $p

    # ---
    # OPTIONAL
    # You could replace the following param values within $c
    # ---
    $c = @{
      AppName = "migrate"
      Env = "dev"
    }

   # ---
   # DO NOT REPLACE THESE PARAMS
   # You shouldn't replace the following params unless you specifically require it
   # ---
   # Resource Group params
   $rgParams = @{
      Name = "rg-$($c.AppName)-$($c.Env)-$($p.Suffix)"
      Location = "$($p.Location)"
   }

   # Test our created variables
   $p
   $c
   $rgParams
   ```

2. ## Create Resource Group

   ```PowerShell
   # Create the ResourceGroup
   New-AzResourceGroup @rgParams
   ```
