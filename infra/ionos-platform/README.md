# Ionos terraform provider

## User experience
- applying changes typically takes a long time (10 min for db, 8 min for nlb + forwarding rule)
- takes some getting used to how it works:
 - need to provision public ip
 - lan is always private, expose it through nlb
- UI: high focus on the designer view, not intuitive for me 
  - nlb only visible in the designer view
- terraform provider works but finding docs is tricky. Attribute references are not shown in resources, only in datasources
- very low default limits (20Gb RAM, 8vcpu)
