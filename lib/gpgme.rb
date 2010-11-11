module GPGMe
  def check_sigs
    `gpg --check-sigs`
  end

  def self.list_sigs
    `gpg --list-sigs`
  end

  def list_fingerprints
    `gpg --list-fingerprints`
  end
end
