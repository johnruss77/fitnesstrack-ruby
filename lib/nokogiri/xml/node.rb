class Nokogiri::XML::Node
  def sub_nodes
    xpath('.//*')
  end

  # get handle to sub nodes iteratively
  def sub_nodes_iterate
    element_children.map{ |kid|
      [kid, kid.descendant_elements]
    }.flatten
  end
end
