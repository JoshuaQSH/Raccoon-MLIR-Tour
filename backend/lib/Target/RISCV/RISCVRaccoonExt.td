nclude "RISCV.td"
def FeatureRaccoonExt
    : SubtargetFeature<"Raccoonext", "HasRaccoonExt", "true",
                       "'RaccoonExt' (Raccon RISC-V Extension)">;
def HasRaccoonExt : Predicate<"Subtarget->hasRaccoonExt()">,
                            AssemblerPredicate<(all_of FeatureRaccoonExt),
                            "'RaccoonExt' (Raccoon RISC-V Extension)">;

include "RISCVInstrInfoRaccoonExt.td"
