# THIS FILE WAS AUTOMATICALLY GENERATED BY generate_conversion_dicts_bot.py DO NOT CHANGE MANUALLY!
# ANY CHANGE WILL BE OVERWRITTEN

from sc2.ids.unit_typeid import UnitTypeId
from sc2.ids.ability_id import AbilityId

# from sc2.ids.buff_id import BuffId
from sc2.ids.upgrade_id import UpgradeId

# from sc2.ids.effect_id import EffectId

from typing import Dict, Set  # , List, Tuple, Union, Optional

STRUCTURE_MORPH: Dict[UnitTypeId, AbilityId] = {
    UnitTypeId.VIKINGFIGHTER: AbilityId.STARPORTTRAIN_VIKINGFIGHTER,
    UnitTypeId.LAIR: AbilityId.UPGRADETOLAIR_LAIR,
    UnitTypeId.HIVE: AbilityId.UPGRADETOHIVE_HIVE,
    UnitTypeId.GREATERSPIRE: AbilityId.UPGRADETOGREATERSPIRE_GREATERSPIRE,
    UnitTypeId.OVERSEER: AbilityId.MORPH_OVERSEER,
    UnitTypeId.PLANETARYFORTRESS: AbilityId.UPGRADETOPLANETARYFORTRESS_PLANETARYFORTRESS,
    UnitTypeId.ORBITALCOMMAND: AbilityId.UPGRADETOORBITAL_ORBITALCOMMAND,
    UnitTypeId.WARPGATE: AbilityId.MORPH_WARPGATE,
    UnitTypeId.OVERLORDTRANSPORT: AbilityId.MORPH_OVERLORDTRANSPORT,
}
