# frozen_string_literal: true

class HedgedocsController < ApplicationController
  before_action :require_login
  before_action :find_optional_project, only: %i[show]

  rescue_from Query::StatementInvalid, with: :query_statement_invalid

  helper :queries

  include QueriesHelper

  helper :sort
  include SortHelper

  menu_item :hedgedocs

  def show
    sort_init 'updatedAt', 'desc'
    sort_update %w[title createdAt updatedAt permission]

    @limit = per_page_option

    scope = HedgedocPad.pads @project

    @hedgedoc_pad_count = scope.count
    @hedgedoc_pad_pages = Paginator.new @hedgedoc_pad_count, @limit, params['page']
    @offset ||= @hedgedoc_pad_pages.offset
    @hedgedoc_pads = scope.order(HedgedocPad.fix_sort_clause(sort_clause))
                          .limit(@limit)
                          .offset(@offset)
  end
end
