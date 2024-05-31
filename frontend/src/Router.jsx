import { createBrowserRouter } from "react-router-dom";
import { Layout } from "./pages/Layout";
import { NotFound } from "./pages/NotFound";
import { Home } from "./pages/Home";
import { Viewall } from "./pages/Viewall";
import { Details } from "./pages/Details";
import { Loan } from "./pages/Loan";
import { Apply } from "./pages/Apply";
import { About } from "./pages/About";
import { Admin } from "./pages/Admin";

export const router = createBrowserRouter([
  {
    path: "/coffeeblock/",
    element: <Layout />,
    errorElement: <NotFound />,
    children: [
      { path: "/coffeeblock/", index: true, element: <Home /> },
      { path: "/coffeeblock/viewall", element: <Viewall /> },
      { path: "/coffeeblock/details/:id", element: <Details /> },
      { path: "/coffeeblock/loan", element: <Loan /> },
      { path: "/coffeeblock/apply", element: <Apply /> },
      { path: "/coffeeblock/about", element: <About /> },
      { path: "/coffeeblock/admin", element: <Admin /> },
    ],
  },
]);
