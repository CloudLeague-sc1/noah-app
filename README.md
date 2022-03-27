# noah

noah app repository.

## Development 
### Requirements
- Flutter 


### Run

```
$ make fetch-content
$ flutter run
```

### Test

```
$ flutter test
```

### Branch Rules

| Usage | Branch Name | Base Branch |
| --- | --- | --- |
| Production | `master` | N/A |
| Latest update | `develop` | `master` |
| Feature development | `feature/{feature_name}` | `develop` |
| Bug fix | `bugfix/{issue_number}-{issue_name}` | `develop` |
| Documentation fix | `docs/{issue_number}-{issue_name}` | `develop` |
| Hotfixes | `hotfix/{patch_title}` | `master` |
