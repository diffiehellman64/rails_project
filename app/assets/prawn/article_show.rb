class ArticleShow < Prawn::Document

  def to_pdf(article)
    font_families.update(
      'Times' => {
        normal: "#{Rails.root}/app/assets/prawn/fonts/times.ttf"
      }
    )
    font 'Times', size: 14
    text(article.text)
 #   render
  end  

end
