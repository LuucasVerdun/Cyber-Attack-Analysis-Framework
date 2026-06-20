rule ransomware_lockbit_payload_indicators_T1486
{
    meta:
        author = "Cyber Attack Analysis Framework"
        date = "2026-06-19"
        description = "Detecta strings e padroes associados a payloads da familia LockBit (variantes 2.0/3.0). Baseado em IOCs publicos (CISA AA23-075A)."
        mitre_attack = "T1486"
        reference = "../../Attack-Categories/Ransomware/README.md"
        tlp = "TLP:CLEAR"

    strings:
        $ransom_note1 = "LockBit" nocase
        $ransom_note2 = "Restore-My-Files.txt" nocase
        $ransom_note3 = ".lockbit" nocase
        $mutex1 = "Global\\LockBit" wide ascii
        $config1 = { 4C 6F 63 6B 42 69 74 20 32 2E 30 } // "LockBit 2.0"
        $api1 = "CreateIoCompletionPort" ascii
        $api2 = "EnumServicesStatusExW" ascii
        $vss_delete = "vssadmin delete shadows" nocase

    condition:
        uint16(0) == 0x5A4D and
        filesize < 5MB and
        (
            2 of ($ransom_note*) or
            ($mutex1 and $vss_delete) or
            $config1
        )
}
