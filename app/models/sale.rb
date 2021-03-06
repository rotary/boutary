# -*- coding: utf-8 -*-
# == Schema Information
#
# Table name: sales
#
#  id               :integer          not null, primary key
#  product_id       :integer          not null
#  number           :string(255)
#  amount           :decimal(16, 2)
#  state            :string(255)
#  error_code       :string(255)
#  payment_sequence :string(255)
#  payment_infos    :text
#  log              :text
#

class Sale < ActiveRecord::Base
  ERROR_CODES = {
    "00000" => "opération réussie.",
    "00003" => "erreur e-transactions.",
    "00004" => "numéro de porteur ou cryptogramme visuel invalide.",
    "00006" => "accès refusé ou site/rang/identifiant incorrect.",
    "00008" => "date de fin de validité incorrecte.",
    "00009" => "erreur vérification comportementale",
    "00010" => "devise inconnue.",
    "00011" => "montant incorrect.",
    "00015" => "paiement déjà effectué.",
    "00016" => "inutilisé.",
    "00021" => "Carte non autorisée.",
    "00030" => "session contrôle sécurité expirée.",
    "00100" => "transaction approuvée ou traitée avec succès.",
    "00102" => "contacter l’émetteur de carte.",
    "00103" => "commerçant invalide.",
    "00104" => "conserver la carte.",
    "00105" => "ne pas honorer.",
    "00107" => "conserver la carte, conditions spéciales.",
    "00108" => "approuver après identification du porteur.",
    "00112" => "transaction invalide.",
    "00113" => "montant invalide.",
    "00114" => "numéro de porteur invalide.",
    "00115" => "émetteur de carte inconnu.",
    "00117" => "annulation client.",
    "00119" => "répéter la transaction ultérieurement.",
    "00120" => "réponse erronée (erreur dans le domaine serveur).",
    "00124" => "mise à jour de fichier non supportée.",
    "00125" => "impossible de localiser l’enregistrement dans le fichier.",
    "00126" => "enregistrement dupliqué, ancien enregistrement remplacé.",
    "00127" => "erreur en « edit » sur champ de mise à jour fichier.",
    "00128" => "accès interdit au fichier.",
    "00129" => "mise à jour de fichier impossible.",
    "00130" => "erreur de format.",
    "00131" => "identifiant de l’organisme acquéreur inconnu.",
    "00133" => "date de validité de la carte dépassée.",
    "00134" => "suspicion de fraude.",
    "00138" => "nombre d’essais code confidentiel dépassé.",
    "00141" => "carte perdue.",
    "00143" => "carte volée.",
    "00151" => "provision insuffisante ou crédit dépassé.",
    "00154" => "date de validité de la carte dépassée.",
    "00155" => "code confidentiel erroné.",
    "00156" => "carte absente du fichier.",
    "00157" => "transaction non permise à ce porteur.",
    "00158" => "transaction interdite au terminal.",
    "00159" => "suspicion de fraude.",
    "00160" => "l’accepteur de carte doit contacter l’acquéreur.",
    "00161" => "dépasse la limite du montant de retrait.",
    "00163" => "règles de sécurité non respectées.",
    "00168" => "réponse non parvenue ou reçue trop tard.",
    "00175" => "nombre d’essais code confidentiel dépassé.",
    "00176" => "porteur déjà en opposition, ancien enregistrement conservé.",
    "00190" => "arrêt momentané du système.",
    "00191" => "émetteur de cartes inaccessible.",
    "00194" => "demande dupliquée.",
    "00196" => "mauvais fonctionnement du système.",
    "00197" => "échéance de la temporisation de surveillance globale.",
    "00198" => "serveur inaccessible (positionné par le serveur).",
    "00199" => "incident domaine initiateur."
  }
  attr_accessible :product_id, :residents_attributes
  belongs_to :product
  has_many :residents, :order => :id
  validates_presence_of :amount, :state, :number, :product
  accepts_nested_attributes_for :residents, :allow_destroy => true

  default_scope order("number DESC")

  def self.payment_infos
    return {:amount => "M", :number => "R", :authorization_number => "A", :sequential_number => "T", :payment_type => "P", :card_type => "C", :transaction_number => "S", :country => "Y", :error_code => "E", :card_expired_on => "D", :payer_country => "I", :bin6 => "N", :signature => "K"}
  end

  before_validation(:on => :create) do
    if self.product
      self.amount = self.product.amount
      self.payment_sequence = self.product.nature.payment_sequence
    end
    self.number = Time.now.to_i.to_s(36) + rand.to_s[2..-1].to_i.to_s(36).rjust(4, '0')[0..3]
    self.state = "estimate"
  end

  def to_param
    self.number
  end
end
