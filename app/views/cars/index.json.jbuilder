cars ||= @cars

json.cars @cars do |car|
	json.year car.year
	json.brand car.brand
	json.model car.model
	json.photo car.photo
	json.description car.description
end