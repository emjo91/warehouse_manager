module WarehouseManager

  def where_value_for_field_in_table_is(options)
    field = options["field"]
    table_name = options["table_name"]
    value = options["value"]
    class_name = options["class_name"]
    
    if value.is_a?(Integer)
       results = DATABASE.execute("SELECT * FROM #{table_name} WHERE #{field} = #{value}")
     else
       results = DATABASE.execute("SELECT * FROM #{table_name} WHERE #{field} = '#{value}'")
     end
    
    results_as_objects = []
    
    results.each do |record| 
      results_as_objects << class_name.new(record)
    end
  end
  
  #SAVES CHANGES TO ROW -- can use some of save method to more fully automate insert method
  def save(class_name)
    attributes = []
  
    # Example  [:@name, :@age, :@hometown]
    instance_variables.each do |i|
      # Example  :@name
      attributes << i.to_s.delete("@") # "name"
    end
  
    query_components_array = []
  
    attributes.each do |a|
      value = class_name.send(a)
    
      if value.is_a?(Integer)
        query_components_array << "'#{a}' = #{value}"
      else
        query_components_array << "'#{a}' = '#{value}'"
      end
    end
  end
  
  
end