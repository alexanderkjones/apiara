class DynamoDBHashModel < AWS::Record::HashModel
	string_attr		:id #Custom HashKey Here
	string_attr 	:string
	boolean_attr 	:boolean
	integer_attr 	:integer
	float_attr		:float
	datetime_attr	:datetime
	date_attr 		:date

	string_attr :set => true

	validates_presence_of :id, :string, :boolean
end