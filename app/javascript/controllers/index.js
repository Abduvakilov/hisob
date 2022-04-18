// Load all the controllers within this directory and all subdirectories.
// Controller files must be named *_controller.js.

import { Application } from 'stimulus';

const application = Application.start();

import AccountController from "./account_controller"
application.register("account", AccountController)

import ConfirmationController from "./confirmation_controller"
application.register("confirmation", ConfirmationController)

import ContractController from "./contract_controller"
application.register("contract", ContractController)

import CounterPartyController from "./counter_party_controller"
application.register("counter_party", CounterPartyController)

import currencyController from "./currency_controller"
application.register("currency", currencyController)

import FlatpickrController from "./flatpickr_controller"
application.register("flatpickr", FlatpickrController)

import PersistencyController from "./persistency_controller"
application.register("persistency", PersistencyController)

import PriceController from "./price_controller"
application.register("price", PriceController)

import ReplaceController from "./replace_controller"
application.register("replace", ReplaceController)

import RowController from "./row_controller"
application.register("row", RowController)

import SelectrController from "./selectr_controller"
application.register("selectr", SelectrController)

import TableController from "./table_controller"
application.register("table", TableController)

import TransactionController from "./transaction_controller"
application.register("transaction", TransactionController)

import UnitController from "./unit_controller"
application.register("unit", UnitController)
