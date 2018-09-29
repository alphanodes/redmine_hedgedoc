module CodimdsHelper
  def new_codimd_pad_path
    "#{RedmineCodimd.settings[:codimd_url]}/new"
  end

  def codimd_pad_url(note)
    "#{RedmineCodimd.settings[:codimd_url]}/#{note.shortid}"
  end

  def codimd_pad_owner(note)
    return if note.User.blank? || note.User.email.blank?

    User.having_mail(note.User.email).first
  end
end
