class CodimdsController < ApplicationController
  before_action :require_login

  rescue_from Query::StatementInvalid, with: :query_statement_invalid

  helper :queries
  helper :additionals_queries

  include QueriesHelper
  include AdditionalsQueriesHelper

  def show
    @codimd_pads = CodimdPad.get_pads
  end
end
