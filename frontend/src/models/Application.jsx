export default class Application {
  constructor (company, amount, index, owner, project, area, reason, time, name, email, lastUpdate, published){
    this.company = company || "company";
    this.amount = amount || "amount";
    this.index = index || "index"
    this.owner = owner || "owner"
    this.project = project || "project"
    this.area = area || "area";
    this.reason = reason || "reason";
    this.time = time || "time";
    this.name = name || "name";
    this.email = email || "email";
    this.lastUpdate = lastUpdate || new Date();
    this.published = published || "no";
    this.image = {src: "/coffeeblock/content/coffee-6", alt: "Coffee bean"}
    // this.image = {src: this.src(), alt: "Coffee bean"}
  }

  // src() {

  //   const random = (Math.random() * (6 - 1) + 1).toFixed(0);
  //   const url = `/coffeeblock/content/coffee-${random}.jpg`

  //   return url;
  // }
}