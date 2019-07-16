module ApplicationHelper
  def link_to_add_round_form(name, f, association, **args) # ( "Add Round", form builder, :rounds, {:class=>"btn btn-primary"} )
    new_object = f.object.send(association).klass.new # => Round.new ( f.obj => Game )
    id = new_object.object_id # uniq id
    fields = f.simple_fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize, f: builder) # render("round", send builder to form)
    end
  #  raise
    link_to(name, '#', class: "add_fields " + args[:class], data: {id: id, fields: fields.gsub("\n", "")})
  end
end

# FIELDS => "<div class=\"round-form form-inline\">\n  <div class=\"form-group string optional game_rounds_kata_id\">
# <label class=\"form-control-label string optional\" for=\"game_rounds_attributes_69937154907740_kata_id\">Kata</label>
# <input class=\"form-control string optional\" type=\"text\" name=\"game[rounds_attributes][69937154907740][kata_id]\" id=\"game_rounds_attributes_69937154907740_kata_id\" /></div>\n
# <div class=\"form-group text optional game_rounds_notes\"><label class=\"form-control-label text optional\"
# for=\"game_rounds_attributes_69937154907740_notes\">Notes</label><textarea class=\"form-control text optional\"
#   name=\"game[rounds_attributes][69937154907740][notes]\" id=\"game_rounds_attributes_69937154907740_notes\">\n</textarea></div>\n
#   <p>\n    <input class=\"hidden\" type=\"hidden\" value=\"false\" name=\"game[rounds_attributes][69937154907740][_destroy]\" i
#   d=\"game_rounds_attributes_69937154907740__destroy\" />\n    <a class=\"remove_record\" href=\"#\">Delete Round</a>\n
#   </p>\n</div>\n"
