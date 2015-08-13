pdf.font_families.update(
  'Times' => {
    normal:      "#{Rails.root}/app/assets/prawn/fonts/times.ttf",
    bold:        "#{Rails.root}/app/assets/prawn/fonts/timesbd.ttf",
    bold_italic: "#{Rails.root}/app/assets/prawn/fonts/timesbi.ttf",
    italic:      "#{Rails.root}/app/assets/prawn/fonts/timesi.ttf"
  }
)

pdf.font('Times', style: :normal)

gerb_path = "#{Rails.root}/app/assets/prawn/images/mvd.png"
gerb = pdf.make_cell( image: gerb_path, image_width: 100, image_height: 50, position: :center, borders: [] )

#cell_1 = pdf.make_cell(content: "this row\n content comes directly", :align => :center, :borders => [:bottom, :top], :border_width => 3)

mvd = pdf.make_cell(content: "<b>МВД по Республике Коми\n\nУправление Государственной Инспекции\nБезопасности Дорожного Движения</b>\n\nул. Д. Каликовой, 27, Сыктывкар, 167981\nтел.: (8212) 28-19-47, факс: (8212) 28-22-34\nE-Mail: 11@gibdd.ru, WEB-сайт: www.11.gibdd.ru\nТелетайп: 181306 «Жезл»", size: 10, borders: [])

date_cell = pdf.make_cell(content: "        ", borders: [:bottom])

outgoing_data = pdf.make_cell(content: "«____» #{Time.now.localtime.strftime("%B")} 2015 г. №13/9")
incomming_data = pdf.make_cell(content: "на № #{@letter.number_outgoing_out} от #{@letter.date_outgoing_out.strftime('%d.%m.%Y')}")
#outgoing_data = pdf.make_table([["«", date_cell, "»", " августа 2015 г. №13/9"]], cell_style: { padding: [0, 0, 0, 0], borders: [] })
theme = pdf.make_cell("┌ ┐")

#pdf.text "#{@article.text}", size: 14
#pdf.image gerb_path, width: 100, height: 50

first = { content: "<b>Foooo fo foooooo</b>", rowspan: 2, width: 50, inline_format: true }
second = { content: "Foooo", colspan: 2 } # <- avoid width here!
 third = { content: "fooooooooooo, fooooooooooooo, fooo, foooooo fooooo", width: 55 }
fourth = { content: "Bar", width: 20 }

# Header table
table_content = [[gerb         ,       ],
                 [mvd          , second],
                 [outgoing_data, fourth],
                 [incomming_data, fourth],
                 [theme, fourth],
                 [1,     2,     3     ]]#, cell_style: { borders: [] }

  table_content2 = [ [first, second       ],
                     [       third, fourth],
                     [1,     2,     3     ] ]


pdf.move_down(20)
pdf.table(table_content, column_widths: [200 , 150, 50], cell_style: {align: :center, inline_format: true })

pdf.table [["Just <font size='18'>some</font> <b><i>inline</i></b>", "", ""],
           ["<color rgb='FF00FF'>styles</color> being applied here", "", ""]],
           cell_style: { inline_format: true }

pdf.text "#{@letter.text}", size: 14
