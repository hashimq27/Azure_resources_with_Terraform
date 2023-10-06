locals {
    student_names=["hashim","salik","thomas", "name1", "name2"]
    deployment   =["Val1","Val2", "Val3", "Val4", "Val5", "Val6", "Val7", "Val8", "Val9", "Val10"]
    gateways     =["gateway1", "gateway2", "gateway3", "gateway4", "gateway5"]
    networks     =["network1", "network2", "network3", "network4", "network5"]
    linux_app=[for f in fileset("${path.module}/yaml", "[^_]*.yaml") : yamldecode(file("${path.module}/yaml/${f}"))]
    linux_app_list = flatten([
    for app in local.linux_app : [
      for linuxapps in try(app.listoflinuxapp, []) :{
        name=linuxapps.name
        os_type=linuxapps.os_type
        sku_name=linuxapps.sku_name     
              }
    ]
])
}