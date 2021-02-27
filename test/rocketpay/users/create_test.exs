defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = %{
        name: "John",
        password: "123456",
        nickname: "john",
        email: "john@email.com",
        age: 18
      }

      {:ok, %User{id: user_id}} = Create.call(params)

      user = Repo.get(User, user_id)

      assert %User{name: "John", age: 18, id: ^user_id} = user
    end

    test "when there are invalid params, returns an error" do
      params = %{
        name: "John",
        password: "123456",
        nickname: "john",
        email: "john@email.com",
        age: 15
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{age: ["must be greater than or equal to 18"]}

      assert expected_response == errors_on(changeset)
    end
  end
end
