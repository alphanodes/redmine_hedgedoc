# frozen_string_literal: true

module HedgedocsHelper
  def new_hedgedoc_pad_path
    "#{RedmineHedgedoc.setting :hedgedoc_url}/new"
  end

  def hedgedoc_pad_url(note)
    "#{RedmineHedgedoc.setting :hedgedoc_url}/#{note.shortid}"
  end

  def hedgedoc_pad_owner(note)
    return if note.User.blank? || note.User.email.blank?

    User.having_mail(note.User.email).first
  end

  def hedgedoc_pad_link(note, project = nil)
    title = if project.present?
              len = project.identifier.length + 1
              max_len = note.title.length
              note.title[len..max_len].strip
            else
              note.title
            end
    link_to_external h(title), hedgedoc_pad_url(note)
  end
end
