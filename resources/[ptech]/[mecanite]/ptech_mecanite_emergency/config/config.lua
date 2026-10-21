Config = {
    Vehicles = {
        pemsblazer = {
            DisplayName = 'EMS Blazer Aqua',
            GameName = 'PTECH_EMSAQUA',

            -- この追加モデルの運転席だけを対象にする。標準 blazer5 は対象外。
            DisableVehicleWeapon = true,

            Mooring = {
                Enabled = true,

                -- 無人かつ水上の時だけ、低速の横流れを減衰させる。
                OnlyWhenInWater = true,
                ArmDelayMs = 1200,
                ScanIntervalMs = 100,
                PassiveDriftSpeedMps = 0.45,
                PassiveVelocityMultiplier = 0.05,

                -- 衝突・押し出し時は係留を外す。位置固定・衝突無効化・無敵化は行わない。
                ReleaseSpeedMps = 1.50,
                ReleaseDistanceM = 0.12,
                ReleaseCooldownMs = 2500,
            },
        },
    },
}
