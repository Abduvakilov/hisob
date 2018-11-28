import PersistencyController from "./persistency_controller.js";

export default class extends PersistencyController {
  static targets = [ 'type', 'counterParty', 'conversionHidden', 'employee',
                     'expenseTypeHidden' ];

  update() {
    this.updateCounterParty();
    this.showConversionFields();
    this.disableContractField();
    this.showExpenseTypeField();
    this.showEmployeeField();
  }

  updateCounterParty() {
  	let id = this.typeTarget.value;
		this.counterParty.updateList(id);
  }

  get counterParty() {
    return this.application.getControllerForElementAndIdentifier(this.counterPartyTarget, 'counter-party')
  }

  showConversionFields() {
    let toConversion = this.typeTarget.value == 11;
    this.conversionHiddenTarget.classList.toggle('d-none', !toConversion)
  }

  disableContractField() {
    if (!['0','10'].includes(this.typeTarget.value))
      this.contract.parentElement.style.display = 'none'
    else
      this.contract.parentElement.removeAttribute('style')
  }

  get contract() {
    return document.querySelector('[data-target="contract.contract"]')
  }

  showExpenseTypeField() {
    if(!this.hasExpenseTypeHiddenTarget) return;
    let toExpense = ['10', '13'].includes(this.typeTarget.value);
    this.expenseTypeHiddenTarget.classList.toggle('d-none', !toExpense)
  }

  showEmployeeField() {
    if(!this.hasEmployeeTarget) return;
    if (this.typeTarget.value == 12) {
      this.InitEmployee();
      this.employeeTarget.closest('.form-group').classList.remove('d-none');
      this.counterPartyTarget.closest('.form-group').classList.add('d-none');
    } else if(this.employeeReady) {
      this.employeeTarget.closest('.form-group').classList.add('d-none');
      this.counterPartyTarget.closest('.form-group').classList.remove('d-none');
    }
  }

  InitEmployee() {
    if(this.employeeReady) return;
    fetch('/employees.json', {credentials: 'same-origin'}).
        then( res => res.json() ).
        then( json => {
          this.employee.selectr.add(json.map(e=>{
            return {
              value: e['id'],
              text:  e['name']
            }
          }))
          this.employeeTarget.setAttribute('ready', '')
      });
  }

  get employee() {
    return this.application.getControllerForElementAndIdentifier(this.employeeTarget, 'selectr')
  }

  get employeeReady() {
    return this.employeeTarget.hasAttribute('ready');
  }
}