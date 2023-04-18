output "api_url_cars" {
   value = "${aws_api_gateway_deployment.rest_api_deployment_cars.invoke_url}${aws_api_gateway_stage.rest_api_stage_cars.stage_name}${aws_api_gateway_resource.resource_cars.path}"
}
