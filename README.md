## SOLID Principles

This project demonstrates the application of the **SOLID principles** using a simple order management system.

---
### Single Responsibility Principle (SRP)

Each interface and class has a single, well-defined responsibility.

* `IOrderItem` handles the basic properties of an item.
* `IPhysicalItem` exclusively manages physical characteristics.
* `IDigitalItem` exclusively manages digital characteristics.
* `TOrder` is responsible for managing the order itself.
* `TOrderService ` is responsible for orchestrating the creation and processing of an order, acting as a business logic layer.
* `ILogListener ` defines the contract for any entity interested in receiving log messages.
* `TForm1 ` (the UI layer) is primarily responsible for display and user interaction, and it acts as a concrete ILogListener to show logs in the UI.

**Without SRP:** If we had a single, monolithic interface (`IItem`), it would encompass multiple responsibilities (physical characteristics, digital characteristics, etc.), thereby violating the SRP.

---
### Open/Closed Principle (OCP)

The `TOrder` class is **open for extension** (you can add new types of `IOrderItem` without modifying `TOrder`) and **closed for modification** (you don't need to change `TOrder`'s internal code to add a new item type).

**Example:** If you wanted to introduce a `TSoftwareLicense` (which is digital but might have an expiration date), you would create a new class implementing `IDigitalItem` or even a new interface `ILicensedItem` inheriting from `IDigitalItem`. `TOrder` would still be able to process it without any internal changes.

---
### Liskov Substitution Principle (LSP)

Wherever an `IOrderItem` is expected (such as in `TOrder`'s `FItems` list), you can substitute it with any of its implementations (`TMetalSparrow` or `TPenguinEbook`) without altering the program's correctness.

**Example:** The code `MyOrder.AddItem(Sparrow, 2)` works perfectly, even though `Sparrow` is an `IPhysicalItem` and `Ebook` is an `IDigitalItem`, because both are fundamentally `IOrderItem`s.

---
### Interface Segregation Principle (ISP)

This principle is a core focus of the design. Instead of a single, large `IItem` interface containing methods like `GetWeightKg`, `GetVolumeCubicMeters`, `GetDownloadLink`, etc., we separate these into smaller, more focused interfaces (`IOrderItem`, `IPhysicalItem`, `IDigitalItem`, `ILogListener`).

Benefit: Classes like `TPenguinEbook` are not forced to implement methods related to weight and volume that are irrelevant to them. Similarly, `ILogListener` ensures that objects only implement the `LogMessage` method if they truly need to receive logs, without being burdened by other irrelevant functionalities.

---
### Dependency Inversion Principle (DIP)

High-level modules should not depend on low-level modules. Both should depend on abstractions. Abstractions should not depend on details. Details should depend on abstractions.

The `TOrder` class (a high-level module) does not depend on concrete implementation classes like `TMetalSparrow` or `TPenguinEbook` (low-level modules). Instead, it depends on abstractions (`IOrderItem`). This reduces coupling and simplifies maintenance and testing.

The `TOrder` class also does not depend on a concrete logging implementation (like `TMemo` in `TForm1`). Instead, it depends on the ILogListener abstraction.

The `TOrderService` (a high-level business logic module) does not directly depend on the concrete `TForm1` (a low-level UI module) for logging. Instead, it also depends on the `ILogListener` abstraction, which is then provided by `TForm1` at runtime. This keeps the business logic clean and independent of the UI details.
