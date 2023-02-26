import React, { useState } from "react";
import axios from "axios";
import Link from "next/link";
import { useRouter } from "next/router";

function SignupPage() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState(null);
  const router = useRouter();

  const handleSubmit = async (event) => {
    event.preventDefault();
    try {
      const response = await axios.post("http://127.0.0.1:8080/crud/findUserByNameAndPassword?name=" + email + "&password=" + password);
      
      const users = response.data;
        if (!users.length) {
          setError("Invalid input");
          return;
        }
      localStorage.setItem("username", users[0].name);
      router.push("/login");
    } catch (error) {
      console.error(error);
      setError("An error occurred while logging in");
    }
  };
  

  return (
    <div className="signup-form">
      <form onSubmit={handleSubmit}>
        <input
          type="text"
          placeholder="email"
          value={email}
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

export default SignupPage;
