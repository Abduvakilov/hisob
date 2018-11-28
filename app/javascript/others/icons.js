import { library, dom, config } from '@fortawesome/fontawesome-svg-core';
import { faCalculator, faAddressCard, faCircle, faHandHoldingUsd, faWeightHanging, faIndustry, faBoxOpen, faMinus, faTruckLoading, faPlus, faSignOutAlt, faChevronLeft, faChevronCircleRight, faTrashAlt, faUserTie, faBriefcase, faBuilding, faMoneyBillAlt, faList, faHome, faCheck, faTimes, faMoneyCheckAlt, faAppleAlt, faUserFriends, faDollarSign, faMapMarkedAlt, faShapes, faCalendarAlt } from '@fortawesome/free-solid-svg-icons';

library.add(faCalculator, faAddressCard, faCircle, faHandHoldingUsd, faWeightHanging, faIndustry, faBoxOpen, faMinus, faTruckLoading, faPlus, faSignOutAlt, faChevronLeft, faChevronCircleRight, faTrashAlt, faUserTie, faBriefcase, faBuilding, faMoneyBillAlt, faList, faHome, faCheck, faTimes, faMoneyCheckAlt, faAppleAlt, faUserFriends, faDollarSign, faMapMarkedAlt, faShapes, faCalendarAlt);
config.autoAddCss = false;
dom.watch({observeMutationsRoot: document}); // fixes issue with turbolinks