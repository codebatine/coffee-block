import { Outlet } from "react-router";
import { Footer } from "../components/footer/Footer";
import { Header } from "../components/header/Header";

export const Layout = () => {
  return (
      <>
        <header>
          <Header />
        </header>
        <main>
          <Outlet />
        </main>
        <footer>
          <Footer />
        </footer>
    </>
  );
};
