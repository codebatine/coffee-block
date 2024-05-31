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
    this.image = {src: this.src(), alt: ""}
  }

  src() {


    const url = "/content/img/coffee-1.jpg"

    return url;
  }
}