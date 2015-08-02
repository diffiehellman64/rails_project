class ArticlesMailer < ApplicationMailer

  default from: 'info@rails-project.ru',
          template_path: 'views/articles/mailer'

  def article_destroyed(article)
    @article = article
    mail to: 'diffiehellman@mail.ru',
         subject: 'Article destroyed!'
  end

end
