export default class Application {
  constructor (company, amount, area, reason, time, name, email, date, published){
    this.company = company || "company";
    this.amount = amount || "amount";
    this.area = area || "area";
    this.reason = reason || "reason";
    this.time = time || "time";
    this.name = name || "name";
    this.email = email || "email";
    this.date = date;
    this.published = published || "no";
  }
}