RG_Map = [
  {
    name        = "rg-01"
    function    = "prd"
    instance_id = "01"
    location    = "northeurope"
    tags = {
      environment = "production"
      owner       = "team-a"
    }
  },
  {
    name        = "rg-02"
    function    = "bak"
    instance_id = "02"
    location    = "westeurope"
    tags = {
      environment = "staging"
      owner       = "team-b"
    }
  },
  {
    name        = "rg-03"
    function    = "dev"
    instance_id = "03"
    location    = "denmarkeast"
    tags = {
      environment = "development"
      owner       = "team-c"
    }
  }
]