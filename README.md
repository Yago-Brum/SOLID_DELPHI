```
## SOLID Principles

This project demonstrates the application of the **SOLID principles** using a simple order management system.

---
### Single Responsibility Principle (SRP)

Each interface and class has a single, well-defined responsibility.

* `IOrderItem` handles the basic properties of an item.
* `IPhysicalItem` exclusively manages physical characteristics.
* `IDigitalItem` exclusively manages digital characteristics.
* `TOrder` is responsible for managing the order itself.

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

This principle is a core focus of the design. Instead of a single, large `IItem` interface containing methods like `GetWeightKg`, `GetVolumeCubicMeters`, `GetDownloadLink`, etc., we separate these into smaller, more focused interfaces (`IOrderItem`, `IPhysicalItem`, `IDigitalItem`).

**Benefit:** Classes like `TPenguinEbook` are not forced to implement methods related to weight and volume that are irrelevant to them.

---
### Dependency Inversion Principle (DIP)

The `TOrder` class (a high-level module) does not depend on concrete implementation classes like `TMetalSparrow` or `TPenguinEbook` (low-level modules). Instead, it depends on **abstractions** (`IOrderItem`). This reduces coupling and simplifies maintenance and testing.
```
