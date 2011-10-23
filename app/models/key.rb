# coding: UTF-8
class Key < ActiveRecord::Base
  has_many :translations, :dependent => :destroy
  has_many :votes, :through => :translations

  validates :key, :uniqueness => true, :presence => true

  def main_locale
    t = translations.where(:language => Rails.configuration.main_locale).first
    t.translation
  end

  def most_voted(language)
    if t = translations.where(:language => language).order("votes_count DESC").first
      t.translation
    end
  end

  def export
    # send_file (generated)
    #

  end

  # Valid options:
  #  - locale: the locale in which import the keys (optional)
  #  - file_path: the path to the YML file (required)
  def self.import(options = {})
    default_options = {
      :locale => Rails.configuration.main_locale,
    }
    options = default_options.merge(options)

    locales = YAML.load(File.read(options[:file_path]))
    raise "Locale in file and main_locale are different" if options[:locale].to_sym != locales.keys.first.to_sym

    result = get_keys(locales.values.first, [], [])

    existing_keys = Key.all.map(&:key).sort
    new_keys = result.map{ |h| h[:key] }

    # Old keys, which does not exist in the new locale file
    # must be removed becase are not used anymore
    existing_keys - new_keys.each do |key|
      Key.find_by_key(key).try(:destroy)
    end

    result.each do |h|
      # If key does not exists, a new key is created
      unless key = Key.find_by_key(h[:key])
        key = Key.create :key => h[:key]
      end
      if existing_keys.include?(h[:key])
        translation = key.translations.where(:language => options[:locale]).first
      end
      if translation
        translation.update_attribute(:translation, h[:value])
      else
        translation = key.translations.new :language => options[:locale], :translation => h[:value]
        translation.save!
      end
    end
  end

  private

  def self.get_keys(locales, keys, result)
    result = []
    value = nil
    if locales.is_a?(Hash)
      locales.keys.each do |key|
        r = get_keys(locales[key], keys + [key], result)
        result << r
      end
      result.flatten
    else
      {:key => keys.join('.'), :value => locales}
    end
  end

end
