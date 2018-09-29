module CodimdHelper
  def new_codimd_pad_path
    "#{RedmineCodimd.settings[:codimd_url]}/new"
  end
end
