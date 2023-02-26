import React, { useState } from "react";
import axios from "axios";
import Link from "next/link";
import { useRouter } from "next/router";

function LoginPage() {
  const [name, setName] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState(null);
  const router = useRouter();

  const handleSubmit = async (event) => {
    event.preventDefault();
    try {
      const response = await axios.post("http://127.0.0.1:8080/peoplecrud/findPeopleByNameAndPassword?name=" + name + "&password=" + password);
      
      const users = response.data;
      if (!users.length) {
        setError("Incorrect name or password");
        return;
      }
      localStorage.setItem("username", name);
      router.push("/mainPage");
    } catch (error) {
      console.error(error);
      setError("An error occurred while logging in");
    }
  };
  

  return (
    <div className="login-form">
      <form onSubmit={handleSubmit}>
        <input
          type="text"
          placeholder="ID"
          value={name}
          onChange={(event) => setName(event.target.value)}
          required
        />
        <input
          type="password"
          placeholder="Password"
          value={password}
          onChange={(event) => setPassword(event.target.value)}
          required
        />
        <Link href="/forgetpassword" className="forgetpassword">Forget password</Link>
        <br></br>
        <button type="submit">Submit</button>
        <button className="signup-link">
        <Link href="/signup">
          Sign up
        </Link>
      </button>
      
      </form>
      {error && <div className="error">{error}</div>}
    </div>
  );
}

export default LoginPage;
