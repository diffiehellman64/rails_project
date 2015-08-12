pdf.font_families.update(
  'Times' => {
    normal:      "#{Rails.root}/app/assets/prawn/fonts/times.ttf",
    bold:        "#{Rails.root}/app/assets/prawn/fonts/timesbd.ttf",
    bold_italic: "#{Rails.root}/app/assets/prawn/fonts/timesbi.ttf",
    italic:      "#{Rails.root}/app/assets/prawn/fonts/timesi.ttf"
  }
)

pdf.font('Times', style: :normal)

logopath = "#{Rails.root}/app/assets/prawn/images/mvd.jpg"
 
pdf.image logopath, :width => 197, :height => 91

cell_1 = pdf.make_cell(content: "this row content comes directly", :align => :center, :borders => [:bottom, :top], :border_width => 3)

table_data = [[cell_1, ''],
              # [{ image: logopath }, "2343"],
              ["3. Row example text", "342"],
              ["4. Row example text", "36"]]

pdf.table(table_data, 
         :cell_style => { :font_style => :normal },
         column_widths: [100 , 200])

#pdf.text "#{@article.text}", size: 14

first = { content: "Foooo fo foooooo", rowspan: 2, width: 50 }
second = { content: "Foooo", colspan: 2 } # <- avoid width here!
 third = { content: "fooooooooooo, fooooooooooooo, fooo, foooooo fooooo", width: 55 }
fourth = { content: "Bar", width: 20 }

  table_content = [ [first, second       ],
                    [       third, fourth],
                    [1,     2,     3     ] ]
  pdf.move_down(20)
pdf.table(table_content, width: 50+55+20, cell_style: {align: :center})
