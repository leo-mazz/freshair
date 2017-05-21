require 'pathname'

require "openid"
require "openid/consumer/discovery"
require 'openid/extensions/sreg'
require 'openid/extensions/pape'
require 'openid/store/filesystem'

class OpenId::ProviderController < ApplicationController
  include OpenID::Server

  skip_before_action :verify_authenticity_token

  def index
    begin
      oidreq = server.decode_request(params)
    rescue ProtocolError => e
      # invalid openid request, so just display a page with an error message
      render :text => e.to_s, :status => 500
      return
    end

    # no openid.mode was given
    if not oidreq
      render :text => "This is an OpenID server endpoint."
      return
    end

    oidresp = nil

    if oidreq.kind_of?(CheckIDRequest)

      identity = oidreq.identity

      if oidreq.id_select
        if oidreq.immediate
          oidresp = oidreq.answer(false)
        elsif not user_signed_in?
          session[:last_oidreq] = oidreq
          # The user hasn't logged in.
          redirect_to :open_id_show_decision_page
          return
        else
          # Else, set the identity to the one the user is using.
          identity = open_id_user_url
        end
      end

      if oidresp
        nil
      elsif self.is_authorized(identity, oidreq.trust_root)
        oidresp = oidreq.answer(true, nil, identity)
      elsif oidreq.immediate
        server_url = url_for :action => 'index'
        oidresp = oidreq.answer(false, server_url)

      else
        session[:last_oidreq] = oidreq
        redirect_to :open_id_show_decision_page
        return
      end

    else
      oidresp = server.handle_request(oidreq)
    end

    self.render_response(oidresp)
  end

  def show_decision_page
    authenticate_user!

    @oidreq = session[:last_oidreq]

    render :template => 'open_id/provider/decide'
  end

  def user_page
    respond_to do |format|
      format.xrds do
        @types = [
          OpenID::OPENID_2_0_TYPE,
          OpenID::OPENID_1_0_TYPE,
          OpenID::SREG_URI
        ]

        render layout: false
      end
      format.any  do
        @xrds_url = open_id_user_page_url(format: :xrds)
        response.headers['X-XRDS-Location'] = @xrds_url
      end
    end
  end

  def idp_xrds
    types = [
             OpenID::OPENID_IDP_2_0_TYPE
            ]

    render_xrds(types)
  end

  def decision
    oidreq = session[:last_oidreq]
    session[:last_oidreq] = nil

    if params[:yes].nil?
      redirect_to oidreq.cancel_url
      return
    else
      id_to_send = params[:id_to_send]

      identity = oidreq.identity
      if oidreq.id_select
        if id_to_send and id_to_send != ""
          session[:approvals] = []
          identity = open_id_user_url
        else
          redirect_to :open_id_show_decision_page, notice: "You must enter a username to in order to send an identifier to the Relying Party."
          return
        end
      end

      if session[:approvals]
        session[:approvals] << oidreq.trust_root
      else
        session[:approvals] = [oidreq.trust_root]
      end
      oidresp = oidreq.answer(true, nil, identity)
      return self.render_response(oidresp)
    end
  end

  protected

  def server
    if @server.nil?
      server_url = url_for :action => 'index', :only_path => false
      dir = Pathname.new(Rails.root).join('db').join('openid-store')
      store = OpenID::Store::Filesystem.new(dir)
      @server = Server.new(store, server_url)
    end
    return @server
  end

  def approved(trust_root)
    return false if session[:approvals].nil?
    return session[:approvals].member?(trust_root)
  end

  def is_authorized(identity_url, trust_root)
    user_signed_in? && self.approved(trust_root)
  end

  def render_response(oidresp)
    if oidresp.needs_signing
      signed_response = server.signatory.sign(oidresp)
    end
    web_response = server.encode_response(oidresp)

    case web_response.code
    when HTTP_OK
      render :text => web_response.body, :status => 200

    when HTTP_REDIRECT
      redirect_to web_response.headers['location']

    else
      render :text => web_response.body, :status => 400
    end
  end
end
