Facter.add(:hypervisor_type) do
  setcode do
    virt_hash = {}
    virtlist = Facter::Core::Execution.exec('sudo virt-what')
    virt_array = virtlist.split("\n")
    if virt_array.length == 2
      virt_hash['hv_high'] = virt_array[0]
      virt_hash['hv_low'] = virt_array[1]
    elsif virt_array.length == 0
      virt_hash['hv_err'] = 'ERR'
    else
      n = 0
      virt_array.each do |hv|
        virt_hash['hv_#{n}'] = hv
        n = n+1
      end
    end
    virt_hash
  end
end
