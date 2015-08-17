content_for(:title, @article.title)
pdf.font_families.update(
  'times' => {
    normal:      "#{Rails.root}/app/assets/prawn/fonts/times.ttf",
    bold:        "#{Rails.root}/app/assets/prawn/fonts/timesbd.ttf",
    bold_italic: "#{Rails.root}/app/assets/prawn/fonts/timesbi.ttf",
    italic:      "#{Rails.root}/app/assets/prawn/fonts/timesi.ttf"
  }
)
pdf.font 'times'
pdf.text "<b>#{@article.title}</b>", inline_format: true, size: 20
pdf.move_down(20)
pdf.text sanitize(@article.text, tags: %w(b br)), inline_format: true
