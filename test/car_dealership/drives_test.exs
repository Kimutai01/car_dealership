defmodule CarDealership.DrivesTest do
  use CarDealership.DataCase

  alias CarDealership.Drives

  describe "drives" do
    alias CarDealership.Drives.Drive

    import CarDealership.DrivesFixtures

    @invalid_attrs %{first_name: nil, last_name: nil, email: nil, phone_number: nil}

    test "list_drives/0 returns all drives" do
      drive = drive_fixture()
      assert Drives.list_drives() == [drive]
    end

    test "get_drive!/1 returns the drive with given id" do
      drive = drive_fixture()
      assert Drives.get_drive!(drive.id) == drive
    end

    test "create_drive/1 with valid data creates a drive" do
      valid_attrs = %{
        first_name: "some first_name",
        last_name: "some last_name",
        email: "some email",
        phone_number: "some phone_number"
      }

      assert {:ok, %Drive{} = drive} = Drives.create_drive(valid_attrs)
      assert drive.first_name == "some first_name"
      assert drive.last_name == "some last_name"
      assert drive.email == "some email"
      assert drive.phone_number == "some phone_number"
    end

    test "create_drive/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Drives.create_drive(@invalid_attrs)
    end

    test "update_drive/2 with valid data updates the drive" do
      drive = drive_fixture()

      update_attrs = %{
        first_name: "some updated first_name",
        last_name: "some updated last_name",
        email: "some updated email",
        phone_number: "some updated phone_number"
      }

      assert {:ok, %Drive{} = drive} = Drives.update_drive(drive, update_attrs)
      assert drive.first_name == "some updated first_name"
      assert drive.last_name == "some updated last_name"
      assert drive.email == "some updated email"
      assert drive.phone_number == "some updated phone_number"
    end

    test "update_drive/2 with invalid data returns error changeset" do
      drive = drive_fixture()
      assert {:error, %Ecto.Changeset{}} = Drives.update_drive(drive, @invalid_attrs)
      assert drive == Drives.get_drive!(drive.id)
    end

    test "delete_drive/1 deletes the drive" do
      drive = drive_fixture()
      assert {:ok, %Drive{}} = Drives.delete_drive(drive)
      assert_raise Ecto.NoResultsError, fn -> Drives.get_drive!(drive.id) end
    end

    test "change_drive/1 returns a drive changeset" do
      drive = drive_fixture()
      assert %Ecto.Changeset{} = Drives.change_drive(drive)
    end
  end
end
