import { Outlet } from "react-router";
import { Footer } from "../components/footer/Footer";
import { Header } from "../components/header/Header";

export const Layout = () => {
  return (
    <div className="container">
      <header className="header">
        <Header />
      </header>
      <main className="main-content">
        <Outlet />
      </main>
      <footer className="footer">
        <Footer />
      </footer>
    </div>
  );
};