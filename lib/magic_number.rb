class MagicNumber
    SIGNATURES = {
        "pdf" => {
            'sign_begin'   => ["25504446"],
            'length_begin' => [4],
  
            'sign_end'     => "0a2525454f460a",
            'offset_end'   => IO::SEEK_END,
            'length_end'   => -7
           },
        "pic" => {
            'sign_begin'   => ["00"],
            'length_begin' => [1],
           },
        "pif" => {
            'sign_begin'   => ["00"],
            'length_begin' => [1]
           },
        "sea" => {
            'sign_begin'   => ["00"],
            'length_begin' => [1]
           },
        "ytr" => {
            'sign_begin'   => ["00"],
            'length_begin' => [1]
           },
        "dba" => {
            'sign_begin'   => ["BEBAFECA"],
            'length_begin' => [4]
           },
        "ico" => {
            'sign_begin'   => ["00000100"],
            'length_begin' => [4]
           },
        "z" => {
            'sign_begin'   => ["1F9D"],
            'length_begin' => [2]
           },
        "bz2" => {
            'sign_begin'   => ["425A68"],
            'length_begin' => [3]
           },
        "gif" => {
            'sign_begin'   => ["474946383961", "474946383961"],
            'length_begin' => [6]
           },
        "tiff" => {
            'sign_begin'   => ["49492A00", "4D4D002A"],
            'length_begin' => [4]
           },
        "tif" => {
            'sign_begin'   => ["49492A00", "4D4D002A"],
            'length_begin' => [4]
           },
        "cr2" => {
            'sign_begin'   => ["49492A0010000000"],
            'length_begin' => [8]
           },
        "jpg" => {
            'sign_begin'   => ["FFD8FF", "FFD8FFE0nnnn4A4649460001", "FFD8FFE1nnnn457869660000"],
            'length_begin' => [3, 12, 12]
           },
        "jpeg" => {
            'sign_begin'   => ["FFD8FF", "FFD8FFE0nnnn4A4649460001", "FFD8FFE1nnnn457869660000"],
            'length_begin' => [3, 12, 12]
           },
        "exe" => {
            'sign_begin'   => ["4D5A"],
            'length_begin' => [2]
           },
        "zip" => {
            'sign_begin'   => ["504B0304", "504B0506", "504B0708"],
            'length_begin' => [4]
           },
        "jar" => {
            'sign_begin'   => ["504B0304", "504B0506", "504B0708"],
            'length_begin' => [4]
           },
        "docx" => {
            'sign_begin'   => ["504B0304", "504B0506", "504B0708"],
            'length_begin' => [4]
           },
        "xlsx" => {
            'sign_begin'   => ["504B0304", "504B0506", "504B0708"],
            'length_begin' => [4]
           },
        "pptx" => {
            'sign_begin'   => ["504B0304", "504B0506", "504B0708"],
            'length_begin' => [4]
           },
        "vsdx" => {
            'sign_begin'   => ["504B0304", "504B0506", "504B0708"],
            'length_begin' => [4]
           },
        "rar" => {
            'sign_begin'   => ["526172211A0700", "526172211A070100"],
            'length_begin' => [7, 8]
           },
        "png" => {
            'sign_begin'   => ["89504E470D0A1A0A"],
            'length_begin' => [8]
           },
        "class" => {
            'sign_begin'   => ["CAFEBABE"],
            'length_begin' => [4]
           },
        "asf" => {
            'sign_begin'   => ["3026B2758E66CF11", "A6D900AA0062CE6C"],
            'length_begin' => [8]
           },
        "ogg" => {
            'sign_begin'   => ["4F676753"],
            'length_begin' => [4]
           },
        "oga" => {
            'sign_begin'   => ["4F676753"],
            'length_begin' => [4]
           },
        "ogv" => {
            'sign_begin'   => ["4F676753"],
            'length_begin' => [4]
           },
        "psd" => {
            'sign_begin'   => ["38425053"],
            'length_begin' => [4]
           },
        "wav" => {
            'sign_begin'   => ["52494646nnnnnnnn", "57415645"],
            'length_begin' => [8, 4]
           },
        "avi" => {
            'sign_begin'   => ["52494646nnnnnnnn", "41564920"],
            'length_begin' => [8,4]
           },
        "mp3" => {
            'sign_begin'   => ["FFFB", "494433"],
            'length_begin' => [2,3]
           },
        "bmp" => {
            'sign_begin'   => ["424D"],
            'length_begin' => [2]
           },
        "iso" => {
            'sign_begin'   => ["4344303031"],
            'length_begin' => [5]
           },
        "flac" => {
            'sign_begin'   => ["664C6143"],
            'length_begin' => [4]
           },
        "mid" => {
            'sign_begin'   => ["4D546864"],
            'length_begin' => [12]
           },
        "midi" => {
            'sign_begin'   => ["4D546864"],
            'length_begin' => [12]
           },
        "doc" => {
            'sign_begin'   => ["D0CF11E0A1B11AE1"],
            'length_begin' => [8]
           },
        "xls" => {
            'sign_begin'   => ["D0CF11E0A1B11AE1"],
            'length_begin' => [8]
           },
        "ppt" => {
            'sign_begin'   => ["D0CF11E0A1B11AE1"],
            'length_begin' => [8]
           },
        "msg" => {
            'sign_begin'   => ["D0CF11E0A1B11AE1"],
            'length_begin' => [8]
           },
        "vmdk" => {
            'sign_begin'   => ["4B444D"],
            'length_begin' => [3]
           },
        "crx" => {
            'sign_begin'   => ["43723234"],
            'length_begin' => [4]
           },
        "fh8" => {
            'sign_begin'   => ["41474433"],
            'length_begin' => [4]
           },
        "dmg" => {
            'sign_begin'   => ["7801730D626260"],
            'length_begin' => [7]
           },
        "tar" => {
            'sign_begin'   => ["7573746172003030", "7573746172202000"],
            'length_begin' => [8,8]
           },
        "mkv" => {
            'sign_begin'   => ["1A45DFA3"],
            'length_begin' => [4]
           },
        "mka" => {
            'sign_begin'   => ["1A45DFA3"],
            'length_begin' => [4]
           },
        "mks" => {
            'sign_begin'   => ["1A45DFA3"],
            'length_begin' => [4]
           },
        "mk3d" => {
            'sign_begin'   => ["1A45DFA3"],
            'length_begin' => [4]
           },
        "webm" => {
            'sign_begin'   => ["1A45DFA3"],
            'length_begin' => [4]
            }
           }
  
    def self.get_signature(ext)
      return SIGNATURES[ext]
    end
      # @see https://en.wikipedia.org/wiki/List_of_file_signatures
      # @since 0.0.1
      # @param [String] file_path Path to analyzable file
      # @return [boolean] wether the file content is in accordance with the extension 
    def self.is_real?(file_path)
      signature = MagicNumber.get_signature(file_path.split(".").last.downcase)
      return false if signature.blank?

      minimum_length = signature['length_begin'].first
      file = File.new(file_path, 'r')
      return false if file.stat.size < minimum_length
      
      real = MagicNumber.check_begin_sign(file, signature) && MagicNumber.check_end_sign(file, signature)
      file.close
      return real
    end
  
    def self.check_begin_sign(file, signature)
      if signature.has_key?("sign_begin")
        i = 0
        while i < signature['sign_begin'].count
          sign = MagicNumber.read_beginning_bytes(file, signature['length_begin'][i])
          return true if (sign.downcase == signature['sign_begin'][i].downcase)
          i += 1
        end
  
        return false
      else
        return true
      end
    end
  
    def self.check_end_sign(file, signature)
      if signature.has_key?("sign_end")
        sign = MagicNumber.read_end_bytes(file, signature['offset_end'], signature['length_end'])
        return (sign.downcase == signature['sign_end'].downcase)
      else
        return true
      end
    end
  
    def self.read_beginning_bytes(file, length)
      file.rewind
      return file.readpartial(length).unpack("H*").first
    end
  
    def self.read_end_bytes(file, offset, length)
      file.seek(length, offset)
      return file.read.unpack("H*").first
    end
  end
